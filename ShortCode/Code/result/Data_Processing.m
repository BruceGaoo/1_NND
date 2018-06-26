N = 16;
K = 4;
N = num2str(N);
K = num2str(K);

% NN
nn = csvread(['P_NN_', num2str(N), '_', num2str(K), '.csv'], 1, 0);
ebn0_nn = nn(:, 1);
fer_nn = nn(:, 2);
ber_nn = nn(:, 3);

% MAP
load(['P_MAP_', num2str(N), '_', num2str(K), '.mat']);
ebn0_map = ebn0';
fer_map = fer';
ber_map = ber';

% SC
load(['P_SC_', num2str(N), '_', num2str(K), '.mat']);
ebn0_sc = ebn0;
fer_sc = fer;
ber_sc = ber;

% SCL L=2
load(['P_SCL2_', num2str(N), '_', num2str(K), '.mat']);
ebn0_scl2 = ebn0;
fer_scl2 = fer;
ber_scl2 = ber;

% Plot
semilogy(ebn0,ber4,'r.--',ebn0,fer4,'r.-','LineWidth',1.5,'MarkerSize',8);
hold on;
semilogy(ebn0,ber2,'g.--',ebn0,fer2,'g.-','LineWidth',1.5,'MarkerSize',8);
hold on;
semilogy(ebn0,ber5,'b.--',ebn0,fer5,'b.-','LineWidth',1.5,'MarkerSize',8);
grid on;
axis([0 maxebn0 0.00001 1]);
legend('GA Sequence BER','GA Sequence FER','WCRP BER','WCRP FER','QUP BER','QUP FER');
xlabel('Eb/N0(dB)');
ylabel('Bit/Frame Error Rate');

% Save
save(['Compare_', num2str(N), '_', num2str(K), '.mat'], ...
    'ebn0_nn', 'fer_nn', 'ber_nn', 'ebn0_map', 'fer_map', 'ber_map', ...
    'ebn0_sc', 'fer_sc', 'ber_sc', 'ebn0_scl2', 'fer_scl2', 'ber_scl2');