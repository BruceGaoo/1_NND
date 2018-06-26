N = 64;
K = 32;
N = num2str(N);
K = num2str(K);

% % NN
% nn = csvread(['P_NN_', num2str(N), '_', num2str(K), '.csv'], 1, 0);
% ebn0_nn = nn(:, 1);
% fer_nn = nn(:, 2);
% ber_nn = nn(:, 3);

% MAP
load(['P_MAP_', num2str(N), '_', num2str(K), '.mat']);
ebn0_map = ebn0';
fer_map = fer';
ber_map = ber';

% SC
load(['P_SC_', num2str(N), '_', num2str(K), '.mat']);
ebn0_sc = ebn0';
fer_sc = fer';
ber_sc = ber';

% SCL L=2
load(['P_SCL2_', num2str(N), '_', num2str(K), '.mat']);
ebn0_scl2 = ebn0';
fer_scl2 = fer';
ber_scl2 = ber';

% Processing
ebn0 = ebn0_map(1:31);
fer_map = fer_map(1:31);
ber_map = ber_map(1:31);
fer_sc = fer_sc(1:31);
ber_sc = ber_sc(1:31);
fer_scl2 = fer_scl2(1:31);
ber_scl2 = ber_scl2(1:31);


% % Plot
% semilogy(ber_nn,'r.-','LineWidth',1.5,'MarkerSize',8);
% hold on;
% semilogy(ber_map,'g.-','LineWidth',1.5,'MarkerSize',8);
% hold on;
% semilogy(ber_sc,'b.-','LineWidth',1.5,'MarkerSize',8);
% hold on;
% semilogy(ber_scl2,'c.-','LineWidth',1.5,'MarkerSize',8);
% grid on;
% % axis([0 maxebn0 0.00001 1]);
% legend('NN','MAP','SC');
% xlabel('Eb/N0(dB)');
% ylabel('Bit Error Rate');

% % Save
% save(['Compare_', num2str(N), '_', num2str(K), '.mat'], ...
%     'ebn0_nn', 'fer_nn', 'ber_nn', 'ebn0_map', 'fer_map', 'ber_map', ...
%     'ebn0_sc', 'fer_sc', 'ber_sc', 'ebn0_scl2', 'fer_scl2', 'ber_scl2');

% save(['Compare_', num2str(N), '_', num2str(K), '.mat'], ...
%     'ebn0', 'ber_map', 'ber_nn', 'ber_sc','ber_scl2');