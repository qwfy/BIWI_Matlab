function plot_3d_headorientation(pt_cld,rot_mat)

offset = -20;
neutral_axes = [0; 0; offset]; % z-axes
orientation = rot_mat* neutral_axes;

% plot depth frame
subplot(1,3,1)
imagesc(pt_cld.z),daspect([1 1 1])

% plot XY view of orientation
subplot(1,3,2)
plot3([0,orientation(1)],[0,orientation(2)],[0,orientation(3)],'-r',...
    'LineWidth',3), hold on 
plot3(orientation(1),orientation(2),orientation(3),...
    'vb','MarkerSize',10,'MarkerFaceColor','g'),
grid on, xlabel('X'), ylabel('Y')
xlim([-20 20]), ylim([-20 20]), zlim([-20 20]), 
set(gca,'YDir','reverse'),view([0 90]),daspect([1 1 1]),drawnow,
hold off

% plot YZ view of orientation with Y and Z axes swapped
subplot(1,3,3)
plot3([0,orientation(1)],[0,orientation(3)],[0,orientation(2)],'-r',...
    'LineWidth',3), hold on 
plot3(orientation(1),orientation(3),orientation(2),...
    'vb','MarkerSize',10,'MarkerFaceColor','g'),
grid on, zlabel('Y'), ylabel('Z'),
xlim([-20 20]), ylim([-20 20]), zlim([-20 20]), 
set(gca,'ZDir','reverse'),view([90 0]),daspect([1 1 1]),drawnow,
pause(0.001)

hold off