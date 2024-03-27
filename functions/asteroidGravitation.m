function [g_x, g_y, g_z] = asteroidGravitation(x, y, z)
% 根据王迪的数据计算小行星的引力场
% INPUTS：
%   x,y,z：距离小行星形心的距离 unit:m
%   g_x, g_y, g_z : 该点处三个方向的重力加速度

load('D:\WenSijie\0_research_data\asteroid_model\王迪数据\itokawa_data.mat');

% 目前数据是从-1000~1000m，中间的数据采用插值 

i_x = floor(x/10) + 101;
i_y = floor(y/10) + 101;
i_z = floor(z/10) + 101;

k_x = mod(x, 10)/10;
k_y = mod(y, 10)/10;
k_z = mod(z, 10)/10;

if mod(x, 10) ~= 0
    g_x = (1-k_x)*vq_x(i_x, i_y, i_z) + k_x*vq_x(i_x+1, i_y, i_z);
else
    g_x = vq_x(i_x, i_y, i_z);
end

if mod(y,10) ~= 0
    g_y = (1-k_y)*vq_y(i_x, i_y, i_z) + k_y*vq_y(i_x, i_y+1, i_z);
else
    g_y = vq_y(i_x, i_y, i_z);
end

if mod(z,10) ~= 0
    g_z = (1-k_z)*vq_z(i_x, i_y, i_z) + k_z*vq_z(i_x, i_y, i_z+1);
else
    g_z = vq_z(i_x, i_y, i_z);
end
   

end