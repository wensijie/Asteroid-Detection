% 利用GP-MPC实现绳系卫星在小行星重力场中的收放控制

clear all 
close all 
useParallel = true;


%% GP对小行星引力场进行拟合
% 目标小行星为itokawa，每隔10米一个间隔，数据范围-1000~1000m 
addpath('classes\');
load('D:\WenSijie\0_research_data\asteroid_model\王迪数据\itokawa_data.mat');
dataNumber = size(vq_x, 1);

load_GP = 1; % 1 表示调用现有GP数据; 0 表示用先前数据
if load_GP == 0
    gp_n = 3;   % input dimension
    gp_p = 3;   % output dimension
    var_f = repmat(0.01, [gp_p,1]);
    var_n = repmat(1e-6 ,[gp_p,1]);
    M = repmat(diag([1e0,1e0,1e0].^2), [1, 1, gp_p]);
    maxsize = 700;

    d_GP = GP(gp_n, gp_p, var_f, var_n, M, maxsize);
    d_GP.isActive = true;
    % 训练点选择为[-1000, -700, -400, -100, 0 , 100, 400, 700, 1000]
    distance = [-1000, -700, -400, -100, 0, 100, 400, 700, 1000];
    test_X = [];
    test_Y = [];

    % get train data
    progress = progressBar('获取测试数据集');
    num = 0;
    for i = 1:9
        for j = 1:9
            for k = 1:9
                test_X = [test_X, [distance(i); distance(j); distance(k)]];
                [g_x, g_y, g_z] = asteroidGravitation(distance(i), distance(j), ...
                    distance(k));
                test_Y = [test_Y, [g_x; g_y; g_z]];

                num = num + 1;
                percentage = num/9^3*100;
                progress.update(percentage);
            end
        end
    end
    progress.close();

    d_GP.add(test_X, 1e8*test_Y');  % 重力场数据为实际数据的10^8倍
    d_GP.updateModel();
    d_GP.optimizeHyperParams();
else
    d_GP = load('GP_data.mat', 'd_GP');
end















