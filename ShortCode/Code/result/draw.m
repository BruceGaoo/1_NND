figure()
semilogy(ebn0, ber_nn,'r.-','LineWidth',1.5,'MarkerSize',8);
hold on;
semilogy(ebn0, ber_map,'g.-','LineWidth',1.5,'MarkerSize',8);
hold on;
semilogy(ebn0, ber_sc,'b.-','LineWidth',1.5,'MarkerSize',8);
hold on;
semilogy(ebn0, ber_scl2,'c.-','LineWidth',1.5,'MarkerSize',8);
grid on;
% axis([0 maxebn0 0.00001 1]);
legend('NN','MAP','SC','SCL');
% legend('NN','MAP','SC');
xlabel('Eb/N0(dB)');
ylabel('Bit Error Rate');