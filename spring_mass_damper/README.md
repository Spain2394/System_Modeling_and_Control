# spring_mass_damper
2nd order spring mass damper system

#### question an alien might ask
Is the open loop system stable. Yes asymptotically stable since the roots are strictly on the left side of the plot.
<img src="./figs/root-locus.png">


### Step response ```F = 1``` (little push)
#### What does the system look like
<img src="./figs/true_state.png">

#### measurement model with noise and kalman state recovery.
```black = kalman state recovery```
```red  = measurement (with noise```
```pink  = ground truth measurement```
<img src="./figs/sensing_3s.png">
