# ion-trajectories
THIS VERSION OF THE README IS BASED ON AN OUTDATED VERSION OF THE CODE, I WILL FIX THIS SOON
Programs for calculating ion trajectories in various versions of the Paul trap, TOF, and whale trap.

Paul Trap Trajectory:

If we look at the Paul trap model from the side, we see that there are 5 pairs of DC electrodes (we're assuming here that the top and bottom electrodes are held at the same voltage, if you want this not to be the case, it shouldn't be too difficult to modify the code). We refer to the five as the far left, left, center, right, and far right electrodes. By default, the voltages on the electrodes are set to be 60 V, 60 V, 0 V, 60 V, and 60 V, respectively. The default RF amplitude is 100 V, and RF frequency is 2 MHz. The coordinates (0,0,0) correspond to the left edge of the far left electrodes, at the end of the trap, exactly in the center of the trap axis.
The trap center for these default voltages is roughly (42.9,0,0). The units of length here are mm.
Before simulating any trajectory, first type into the command line:

resultsPaul = compilePaulFields();

This will store an object called resultsPaul in the matlab workspace.
Then, in order to simulate the trajectory of an ion of mass m, with initial position (x,y,z), initial velocity (vx,vy,vz), for a total time T, using all of the default parameters above, you type into the command line:

[trajectory,simTimes] = paulTrajectory(resultsPaul,[x y z vx vy vz],T,m);

Units:
  x,y,z - mm
  vx,vy,vz - mm/s
  T - s
  m - AMU

So to simulate a strontium ion (mass 88) initially at rest at the point (42,0.5,1) for 10 microseconds, you would enter:

[trajectory,simTimes] = paulTrajectory(resultsPaul,[42 0.5 1 0 0 0],10e-6,88);

This will produce a 3D graph of the trajectory, as well as returning the 6 x N array trajectory and 1 x N array simTimes. simTimes(i) is the simulation time corresponding to an index i, and trajectory(i,:) gives the vector [x y z vx vy vz] of the ion at simTimes(i). From here you can graph the positions and velocities as you wish.

If you want to change the voltages on the DC electrodes, the RF amplitude, or the RF frequency, you'll need to open up the paulTrajectory.m file. To change the frequency, simply change the value of RFfreq, it's near the top. To change the values of the DC electrodes and RF amplitude, look for the array called amps. It should be the first object in the while loop. You can define the voltages to arbitrary values by changing the values of amps:

amps = [VFarLeft VLeft VCenter VRight VFarRight RFAmplitude];

You should see some commented out code below the declaration of amps, if/elseif/else statements involving switch times. This allows you to change the values of amps with time. Just comment out the original amps declaration, un-comment this code, and define whatever switch times and amps values you want.


Whale Trap Trajectory:

The process is essentially the same as the Paul trap. First generate the results array:

resultsWhale = compileWhaleFields();

Then, to calculate a trajectory, 

[trajectory,simTimes] = whaleTrajectory(resultsWhale,[x y z vx vy vz],T,m);

For the whale trap model, the trap center is at (0,0,0) (assuming both DC electrodes are at the same voltage). By default, the DC electrodes are at 0.5 V, the RF amplitude is 150 V, and the RF frequency is 2 MHz. You can change these parameters in the same way as in the Paul trap. Here, amps is in the following order:

amps = [VTopDCelectrode VBottomDCelectrode RFamplitude];

So you should see by default amps = [0.5 0.5 150]. Feel free to change these values, though above a certain threshold voltage on the DC electrodes, there's no longer a stable equilibrium at (0,0,0). This should be between about 5-10 V. You can also try to add time switching, like in the Paul trajectory code.


Loading Paul Trap Trajectory:

This is a variation of the Paul trap I designed for loading from the TOF, where instead of the RF electrodes spanning the whole trap, they're cut off at the far left end and replaced with two more DC electrodes, which are coupled to the already existing far left electrodes. The model also extends farther out to the left so you can simulate incoming ions being loaded in along the axis. To generate the results array, type:

resultsPaulLoading = compilePaulLoadingFields();

This will take longer to run, probably 10-15 minutes. Then, to simulate a trajectory, type:

[trajectory,simTimes] = paulLoadingTrajectory(resultsPaulLoading,[x y z vx vy vz],T,m);

By default the voltages in amps are set to switch twice, demonstrating the loading procedure. I recommend starting with calculating this trajectory:

[trajectory,simTimes] = paulLoadingTrajectory(resultsLoading,[-40 0 0.3 1.4e7 0 0],45e-6,88);

This will load the ion into the trap. You can then mess around with the initial conditions, voltages, or switch times to see how it all changes.
