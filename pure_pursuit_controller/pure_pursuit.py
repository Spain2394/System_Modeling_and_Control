import numpy as np
import math 
import matplotlib.pyplot as plt


# see https://raw.githubusercontent.com/AtsushiSakai/PythonRobotics/master/PathTracking/pure_pursuit/pure_pursuit.py
# ref: Robotic Vision and Control Ch. 4, Peter Corke 

# parameters
dt = 0.1      # [s] time step
Kv = 0.001   # velocity controls
Ki = 0.001   # integral gain
Kw = 0.1      # steering speed controls
Ld = 3        # [m] look forward distance 
k = 0.2       # look forward gain
Kh = 2        # angle gain

# constraints
vmax = 5     # max linear speed [m/s]
vmin = 0.2    # max unicycle rotation [rad/s] 

# simulation parameters
show_simulation = True
# plt.style.use('fivethirtyeight') # also a good theme
plt.style.use('seaborn')

class Course:
    def __init__(self,cx,cy):
        self.cx = cx
        self.cy = cy
        self.prev_nearest_point_index = None

    def search_target_index(self, unicycle):
        # speed up point search
        if self.prev_nearest_point_index is None:
            # search nearest point 
            dx = [unicycle.x - icx for icx in self.cx]
            dy = [unicycle.y - icy for icy in self.cy]
            d = np.hypot(dx, dy)
            ind = np.argmin(d)
            self.prev_nearest_point_index = ind
        else: 
            ind = self.prev_nearest_point_index
            distance_this_index = unicycle.distance(self.cx[ind], self.cy[ind])
            while True:
                print("ind", ind)
                distance_next_index = unicycle.distance(self.cx[ind + 1], self.cy[ind + 1])

                if distance_this_index < distance_next_index:
                    break
                ind = ind + 1 if (ind + 1) < len(self.cx) else ind
                distance_this_index = distance_next_index
            self.prev_nearest_point_index = ind
        Lf = k * unicycle.v + Ld
    
        # determin distance from center point to target poitn
        while Lf > unicycle.distance(self.cx[ind], self.cy[ind]):
            if (ind + 1) >= len(self.cx):
                break
            ind +=1

        return ind, Lf

class States:
    def __init__(self):
        self.x = []
        self.y = []
        self.yaw = []
        self.v = []
        self.w = []
        self.t = []
        self.e = []

    def append(self,t,unicycle):
        self.x.append(unicycle.x)
        self.y.append(unicycle.y)
        self.v.append(unicycle.v)
        self.w.append(unicycle.w)
        self.e.append(unicycle.w)
        self.t.append(t)

class Unicycle:
    def __init__(self, x = 0.0, y = 0.0, yaw=0.0, v=0.0, w=0.0):
        self.x = x
        self.y = y
        self.yaw = yaw
        self.v = v
        self.w = w
        self.e = 0
    
    def update(self, vp, wp, gamma, crosstrack):
        self.x += self.v * math.cos(self.yaw) * dt
        self.y += self.v * math.sin(self.yaw) * dt
        self.yaw = self.w * dt
        self.v += vp
        if self.v > vmax:
            self.v = vmax
        else: pass
        if self.v < vmin:
            self.v = vmin
        else: pass
        self.w += gamma

        self.e = crosstrack

    def distance(self, x,y):
        dx = self.x - x
        dy = self.y - y
        return math.sqrt(dx**2 + dy**2)

# def w_control(target, current):
#     aw = Kw * (target-current)
#     return aw

def proportional_controller_rot(current):
    aw = Kw * current
    print("rotation control: ", aw)
    return aw

def proportional_controller_vel(target, current, crosstrack, e_hist, time):
    av = Kv * crosstrack + Ki * sum(e_hist) * time
    print("velocity control: ", av)
    return av

def pure_pursuit_steer_control(unicycle, trajectory, pind):
    # compute pure pursuit control at nearest path index 
    ind, Lf = trajectory.search_target_index(unicycle)

    if pind >= ind:
        ind = pind

    if ind < len(trajectory.cx):
        tx = trajectory.cx[ind]
        ty = trajectory.cy[ind]
    else: # go towards goal 
        tx = trajectory.cx[-1]
        ty = trajectory.cy[-1]
        ind = len(trajectory.cx) - 1 

    # target heading = atan(dy/dx)
    crosstrack = unicycle.distance(tx,ty) - Lf
    print("crosstrack error", crosstrack)
    alpha = math.atan2(ty - unicycle.y, tx - unicycle.x) - unicycle.yaw
    print("alpha", alpha)
    gamma = alpha * Kh
    return gamma, crosstrack, ind 

if __name__ == "__main__":

    cx = np.arange(0,50,0.5)
    cy = [math.cos(ix/6.0) * ix/2 + math.cos(ix/3.0) * ix/5 for ix in cx]
    e_hist = []

    max_acc = 5
    target_vel = 5   # [m/s]
    # target_w    = 1   # [rad/s]

    T = 100.0       # simulation time

    # initial state 
    unicycle = Unicycle(x = -0.0, y = -3.0, yaw = 0.0, v = 0.0, w = 0.01)
    lastIndex = len(cx) - 1
    print("last index", lastIndex)
    time = 0.0

    states = States()
    states.append(time, unicycle)
    target_path = Course(cx,cy)
    target_ind, _ = target_path.search_target_index(unicycle)
    print("target_index", target_ind)

    while T>= time and lastIndex > target_ind:
        print("time")
        # wp = vel_control(target_vel, unicycle.v)
        # gamma = yaw_goal - yaw
        # e = L - Ld, where L is the distance to the target
        gamma, crosstrack, target_ind = pure_pursuit_steer_control(unicycle, target_path, target_ind)

        # if lastIndex <= target_ind: 
        #     break 

        e_hist.append(crosstrack)
        wp = proportional_controller_rot(unicycle.w)
        vp = proportional_controller_vel(target_vel, unicycle.v, crosstrack, e_hist, time)
        # wp = vel_control(target_w, unicycle.w)

        # update all the values
        unicycle.update(vp, wp, gamma, crosstrack) # update positions based on control inputs computed during pp
        
        time +=dt
        # store all of the new values
        states.append(time, unicycle)

        if show_simulation:
            plt.cla()
            # to stop simulation with esc 
            plt.gcf().canvas.mpl_connect(
                'key_release_event',
                lambda event: [exit(0) if event.key == 'escape' else None])
            plt.plot(cx, cy, lw=2, color = 'black', label="target path")
            # @ todo plot unicycle
            plt.legend(frameon=True)
            plt.plot(states.x, states.y, lw=2, color='green', label="trajectory")
            
            plt.plot(cx[target_ind], cy[target_ind], marker=".",markersize=10,color='r',label="target")
            # plt.axis([xmin xmax ymin ymax])
            plt.axis("equal")
            plt.grid(True)
            plt.legend(frameon=True)

            plt.title("Speed [m/s] " + str(unicycle.v)[:4]+ "    ld = " + str(Ld) + "[m]")
            
            plt.pause(0.001) 

    # plt.savefig('./figs/L_' + str(Ld) +'_gain_ki=' + str(Kv) +'_.png')
    plt.savefig('./figs/final_Ld=3.png')
    # does it work
    assert lastIndex >= target_ind, "Cannot reach goal"


    





