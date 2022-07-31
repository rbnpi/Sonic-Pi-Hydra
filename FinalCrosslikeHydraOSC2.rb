#Sonic Pi code to drive Hydra sketch "Crosslike"
#written by Robin Newman,  5 July 2022,amended 31st Julay 2020
#feed both sound (via loopback) and OSC calls
#via a node bridge server to hydra
#running in Chrome
use_osc "localhost",41234 #port for node bridge server
#osc "/mask",0;stop
use_random_seed 10822#6789876 #change for different patterns
use_bpm 60 #fix internal bpm
define :maskit do |dir| #fades sketch screen by adjusting mask opacity
  in_thread do
    if dir == "up"
      
      6.times do |x|
        #changes mask from solid black to transparent in 6 steps
        osc "/mask",x/5.0
        sleep 1
      end
    else
      #changes mask from transparent to black in 11 steps
      11.times do |x|
        osc "/mask",(10-x)/10.0
        sleep 0.7
      end
    end
  end
end

at 0 do #this section initiatest the start and end of sketch
  set :kill,false #flag used in stop sequence
  maskit "up" #enables chrome screen
end
at 110 do #end sequence starts
  with_fx :reverb,room: 0.8,mix: 0.7 do
    sample :ambi_lunar_land, amp: 8,beat_stretch: 7
  end
  maskit "down" #fade out chrome screen
  sleep 4
  set :kill,true #flag to stop the sound
  stop
end

define :linkbpm do #adjusts link speed up and down during the sketch
  
  in_thread do #in thread raise the link bpm from 40 to 140
    set_link_bpm! 40
    sp=40
    100.times do
      sleep 0.4
      sp+=1
      set_link_bpm! sp
      
    end
    sleep rt(48) #real time 48 seond wait
    100.times do #decrease the link speed back to 40
      sleep 0.4
      sp -= 1
      set_link_bpm! sp
    end
  end
end

cc=[-1,-0.5,0.5,1] #colour change sequence
cc2=cc+[0] #additional sequence involving 0 colour.
#nb don't use for all three rgb at same time or blank screen
link #switch to follow link mode from here on
linkbpm #vary link speed
with_fx :level,amp: 0.6 do #adjust overall sound level
  
  live_loop :sd do #main sound generation loop
    tick
    stop if get(:kill) #check if time to stop loop
    if current_bpm >138 #switch transpose according to bpm
      use_transpose 7
    else
      use_transpose 0
    end
    #base note
    synth :bass_foundation,note: :e1,sustain: 0.5,release: 0.5,amp: 0.5 if spread(3,11).tick(:sp)
    #switch colours synced with base note
    osc "/s",cc2.choose,cc.choose,cc.choose  if spread(3,11).look(:sp)
    #change density gives 1,2 or 3 notes together
    density dice(4) do
      use_synth  [:bass_foundation,:fm].choose #vary synth
      #play selected note from pentatonic minor scale
      play scale( :e2,:minor_pentatonic,num_octaves: 2).choose ,amp: rrand(0.5,8),\
        cutoff: rrand_i(70,110),release: [rt(0.5),rt(1)].choose,amp: 0.7
    end
    puts current_bpm #monitor bpm in log
    sleep [0.5,1].choose #delay between notes varies to give rhythm
    
    if look%9==0 #periodically change colours:
      #different rbg pattern to above cc,cc2,cc opposed to cc2,cc,cc
      osc "/s",cc.choose,cc2.choose,cc.choose
      #synced with snare sample
      sample :elec_mid_snare ,amp: 2;sleep 0.5
    end
  end
end

