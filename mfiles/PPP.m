lambda = @(x) 300*(x(:,1).^2 + x(:,2).^2);
lamstar = 120;
N=poissrnd(lamstar); x = rand(N,2)-0.5; % homogeneous PP
ind = find(rand(N,1) < lambda(x)/lamstar);
xa = x(ind,:); % thinned PP
figure;
plot(1000*xa(:,1),1000*xa(:,2), '^k');
xlim([-500 500]);
ylim([-500 500]);

hold on;
grid on;

box on;
% title('Example of mmWave BSs distribution','FontSize',14, 'FontWeight','bold');
xlabel('x-axis','FontSize',14, 'FontWeight','bold');
ylabel('y-axis','FontSize',14, 'FontWeight','bold');
% legend({'mmWave BS'},'FontSize',14, 'FontWeight','bold');
%%
h = open('sysmodel1.fig');
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'sysmodel1.pdf','-dpdf','-r0');
%%
save('input.mat', 'x');
%%
fileID = fopen('exptable_148.txt','w');
for i=1:length(x)
    fprintf(fileID,'%f %f\n',x(i,1),x(i,2));
end
fclose(fileID);
%%
lambda = @(x) 300*(x(:,1).^2 + x(:,2).^2);
lamstar = 120;
N=poissrnd(lamstar); x = rand(N,2)-0.5; % homogeneous PP
ind = find(rand(N,1) < lambda(x)/lamstar);
xa = x(ind,:); % thinned PP

figure;
plot(1000*x(:,1),1000*x(:,2), '^k');
hold on;

for i=1:size(x,1)
    for j=i+1:size(x,1)
%         if i~=j
            dist = (x(i,1)-x(j,1))^2 + (x(i,2)-x(j,2))^2;
            if dist <= 200^2
                plot([x(i,1) x(j,1)], [x(i,2) x(j,2)]);
            end
%         end
    end
end


grid on;
box on;
% xlim([-500 500]);
% ylim([-500 500]);
% title('Example of mmWave BSs distribution','FontSize',14, 'FontWeight','bold');
xlabel('x-axis','FontSize',14, 'FontWeight','bold');
ylabel('y-axis','FontSize',14, 'FontWeight','bold');




