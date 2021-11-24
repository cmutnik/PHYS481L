from uncertainties.umath import *
from uncertainties import ufloat, unumpy

xyerror = 2.
dist_target_detector = 2600.

gamma1_xhit = np.genfromtxt('ch4num4c.txt')[:,0]
gamma1_yhit = np.genfromtxt('ch4num4c.txt')[:,1]
#gamma1_energy = np.genfromtxt('ch4num4c.txt')[:,2]
gamma2_xhit = np.genfromtxt('ch4num4c.txt')[:,3]
gamma2_yhit = np.genfromtxt('ch4num4c.txt')[:,4]
#gamma2_energy = np.genfromtxt('ch4num4c.txt')[:,5]

points_x1, points_y1, points_x2, points_y2 = [],[],[],[]
for i in range(len(gamma1_xhit)):
	points_x1.append(ufloat(gamma1_xhit[i], xyerror))
	points_y1.append(ufloat(gamma1_yhit[i], xyerror))
	points_x2.append(ufloat(gamma2_xhit[i], xyerror))
	points_y2.append(ufloat(gamma2_yhit[i], xyerror))

theta1,theta2=[],[]
for j in range(len(points_x1)):
	xx1 = points_x1[j]*points_x1[j]
	yy1 = points_y1[j]*points_y1[j]
	xx2 = points_x2[j]*points_x2[j]
	yy2 = points_y2[j]*points_y2[j]
	theta1.append(tan(sqrt(xx1+yy1)/dist_target_detector))
	theta2.append(tan(sqrt(xx2+yy2)/dist_target_detector))

theta_rad,theta_deg = [],[]
for n in range(len(theta1)):
	angle_rad=theta1[n]+theta2[n]
	angle_deg=(theta1[n]*np.pi*180.)+(theta2[n]*np.pi*180.)
	theta_rad.append(angle_rad)
	theta_deg.append(angle_deg)
