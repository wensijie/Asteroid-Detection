% 仿真相关图片的绘制

%% 绘制小行星的二维相图
load ("testData.mat");
% z=0平面
[X,Y] = meshgrid([-1e3:100:1e3]);
n = size(X, 1);
U = nan(n,n);
V = nan(n,n);

for i = 1:n
    for j = 1:n
        [U(i,j), V(i,j), ~] = asteroidGravitation(X(i,j), Y(i,j), 0); 
    end
end

U_norm = U./sqrt(U.^2+V.^2);
V_norm = V./sqrt(U.^2+V.^2);
quiver(X,Y, U_norm, V_norm)
xlabel('X(m)')
ylabel('Y(m)')
title('Z=0 平面内引力场')

% x=0平面
[Y, Z] = meshgrid([-1e3:100:1e3]);
n = size(Y,1);
V = nan(n,n);
W = nan(n,n);
for i = 1:n
    for j = 1:n
        [~, V(i,j), W(i,j)] = asteroidGravitation(0, Y(i,j), Z(i,j)); 
    end
end
W_norm = W./sqrt(W.^2+V.^2);
V_norm = V./sqrt(W.^2+V.^2);
quiver(Y,Z, U_norm, V_norm)
xlabel('Y(m)')
ylabel('Z(m)')
title('x=0 平面内引力场')
xlim([-1100, 1100])
ylim([-1100, 1100])

%% 绘制小行星三维图，并绘制引力场强度
addpath('D:\WenSijie\0_research_data\asteroid_model\GaMA\data\MeshFiles\Itokawa');
astero_obj = readwObj('Itokawa_50000.obj');
cntr = mean(astero_obj.v,1);
tval = zeros(size(astero_obj.v, 1), 1);

p = patch('Vertices', astero_obj.v, 'Faces', astero_obj.f.v, 'FaceVertexCData', tval);
hold on 
colormap jet;
ch = colorbar('horiz'); %将colorbar调整为水平
set(get(ch,'title'),'string','引力强度(m/s^2)','FontSize',14, 'position',[300 -35]);

shading interp;
lighting phong;
camlight('right');
camproj('perspective');
axis square;
axis on;
axis equal
axis tight;
verts=get(p,'Vertices');
faces=get(p,'Faces');
xlabel('X(km)');
ylabel('Y(km)');
zlabel('Z(km)');
xlim([-1.1, 1.1]);
ylim([-1.1, 1.1]);
zlim([-1.1, 1.1]);
% 计算引力强度
gravityMagnitude = sqrt(test_Y(1,:).^2 + test_Y(2,:).^2 + test_Y(3,:).^2);
gravityPosition = 1e-3*test_X;
scatter3(gravityPosition(1,:),gravityPosition(2,:),gravityPosition(3,:),[] ,gravityMagnitude,'.');





