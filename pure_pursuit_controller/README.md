# pure_pursuit_controller
geometric path tracking algorithm

## Control problem 

velocity is controlled by the difference between the look ahead distance and the local target.
```
    av = Kv * crosstrack + Ki * sum(e_hist) * time
```
turning speed is controlled by 
```
    gamma = atan2(targety - currenty , targetx - currentx) - self.yaw
    aw = Kw * alpha
```

### path generation, and state generation
### affect of lookahed distance
```ld = 1```
<img src = "./figs/L_1_gain_k=0.001_.png">

```ld = 2```
<img src = "./figs/L_2_gain_k=0.001_.png">

```ld = 4```
<img src = "./figs/L_4_gain_k=0.001_.png">

```ld = 5```
<img src = "./figs/L_5_gain_k=0.001_.png">

```ld = 6```
<img src = "./figs/L_6_gain_k=0.001_.png">

**Note**
robot moves quite slow at the start ? D-Controller ? 
robot cannot keep trajectory if ld < 0.5 or ld > 6

### affect of steering speed gain ```(Kw)```

Using ```ld = 5```

```Kw = 1.1```
<img src = "./figs/L_6_gain_kw=1.1_.png">

```Kw = 2```
Lost tracking...
<img src = "./figs/L_6_gain_kw=2_.png">

### affect of velocity P gain ```(Kv)```
```Ki = 0.0001```

```Kv = 0.001```
Lost tracking...
<img src = "./figs/L_6_gain_kv=0.001_.png">

```Kv = 0.0001```
Lost tracking...
<img src = "./figs/L_6_gain_kv=0.0001_.png">

```Kv = 0.1```
Lost tracking...
<img src = "./figs/L_6_gain_kv=0.1_.png">


```Kv = 0.5```
Lost tracking...
<img src = "./figs/L_6_gain_kv=0.5_.png">


```Kv = 1```
Lost tracking...
<img src = "./figs/L_6_gain_kv=1_.png">


```Kv = 10```
Lost tracking...
<img src = "./figs/L_6_gain_kv=10_.png">

### affect of velocity P gain ```(Ki)```
```Kv = 10```

**Take away:**
At high speeds, you get overshoot or instability using control law.
```vmax = 10```, using ```vmax = 5``` works much better with a look ahead distance of 3.
<img src = "./figs/final_Ld=3.png">
