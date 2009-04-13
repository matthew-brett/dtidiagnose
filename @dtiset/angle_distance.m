function dtheta = angle_distance(o1, o2)
% Calculates the angle distance between acquisitions
% See angle method
%
% Angle difference allows for the fact that DTI
% vectors are bidirectional. 
% Thus vectors angle 0 is identical to vectors angle pi
% Note NaN returned for comparison to B0 angle to non B0 angle

theta = angle(o1, o2);
dtheta = min([theta pi-theta], [], 2);
