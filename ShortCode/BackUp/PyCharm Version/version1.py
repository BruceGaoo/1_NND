# This version is a prototype trained with non-noise data.
# 16--(relu)128--(relu)64--(relu)32--(sigmoid)8

import tensorflow as tf
import polarfunctions


# #### 1. Python Parameters

# Polar Code Parameters
n = 4
R = 0.5
N = pow(2, n)
K = int(N*R)
m = pow(2, K)
SNRt = 1
if n == 2:
    free_sets = [3, 4]
elif n == 3:
    free_sets = [4, 6, 7, 8]
elif n == 4:
    free_sets = [8, 10, 11, 12, 13, 14, 15, 16]

# Training Parameters
num_nodes = [N, 128, 64, 32, K]
num_layers = len(num_nodes)
epsilon_init = 0.12  # Variables Initialization Parameter
reg = 0  # Regularization Parameter
total_step = pow(2, 14)
alpha = 0.01

# Data Generation
U0 = polarfunctions.generateU0(K)
U = polarfunctions.generateU(U0, N, free_sets)
X0 = polarfunctions.generateX0(U)
for i in range(m):
    for j in range(N):
        X0[i][j] = 1 - 2*X0[i][j]


# #### 2. tf Parameters

# Data Set Initialization
X = tf.constant(X0, dtype=tf.float32, name='x-input')
Y_ = tf.constant(U0, dtype=tf.float32, name='y-input')
noise = tf.Variable(tf.random_normal((m, N)))

# Parameters Initialization
w1 = tf.Variable(tf.random_uniform((num_nodes[0], num_nodes[1]), -epsilon_init, epsilon_init, seed=1), name='weight1')
w2 = tf.Variable(tf.random_uniform((num_nodes[1], num_nodes[2]), -epsilon_init, epsilon_init, seed=1), name='weight2')
w3 = tf.Variable(tf.random_uniform((num_nodes[2], num_nodes[3]), -epsilon_init, epsilon_init, seed=1), name='weight3')
w4 = tf.Variable(tf.random_uniform((num_nodes[3], num_nodes[4]), -epsilon_init, epsilon_init, seed=1), name='weight4')
b1 = tf.Variable(tf.random_uniform((1, num_nodes[1]), -epsilon_init, epsilon_init, seed=1), name='bias1')
b2 = tf.Variable(tf.random_uniform((1, num_nodes[2]), -epsilon_init, epsilon_init, seed=1), name='bias2')
b3 = tf.Variable(tf.random_uniform((1, num_nodes[3]), -epsilon_init, epsilon_init, seed=1), name='bias3')
b4 = tf.Variable(tf.random_uniform((1, num_nodes[4]), -epsilon_init, epsilon_init, seed=1), name='bias4')

# Forward Network Definition
a0 = X
a1 = tf.nn.relu(tf.matmul(a0, w1)+b1)
a2 = tf.nn.relu(tf.matmul(a1, w2)+b2)
a3 = tf.nn.relu(tf.matmul(a2, w3)+b3)
a4 = tf.nn.sigmoid(tf.matmul(a3, w4)+b4)

# Cost Function and Training Step Definition
h = tf.clip_by_value(a4, 1e-10, 1.0-1e-7)  # The tf.float32 data type cannot exactly describe 1.0-1e-10
J_List = Y_*tf.log(h)+(1-Y_)*tf.log(1-h)
J_Mean = -tf.reduce_sum(J_List)/m
train_step = tf.train.GradientDescentOptimizer(alpha).minimize(J_Mean)


# #### 3. Training
with tf.Session() as sess:
    init_op = tf.global_variables_initializer()
    sess.run(init_op)
    for i in range(total_step):
        sess.run(train_step)
        if i % 100 == 0:
            J_value = sess.run(J_Mean)
            print('Training Step: %d Cost Value: %g' % (i, J_value))
    h_value = sess.run(a4)
    for i in range(m):
        print(h_value[i])
