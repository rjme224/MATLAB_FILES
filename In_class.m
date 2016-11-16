% Jason Merrick 
% In-class problem set #1
clc
% Problem 1 (Create a matrix 'A' from 1 to 1000)
disp('Problem 1')
A = linspace(1,1000,1000)
disp('---------------------------------------------------------------------------------------------------------')

% Problem 2 Create a matrix "B" from 333 to 3 by 3's)

disp('Problem 2')
B = linspace(333,3,111)
disp('---------------------------------------------------------------------------------------------------------')


% Problem 3 - Create a matrix "C" that when subtracted from a matraix
% [linspace(1,100,100)], it equals a row of 100 0's.

disp('Problem 3')
C = [1:100]

%Test of Problem 3

Pr2 = [linspace(1,100,100)-C]
disp('---------------------------------------------------------------------------------------------------------')

% Problem 4 Matrix of  "Even" and "Odd" with 200 even and odd numbers
% respectively

disp('Problem 4')
Even = 2:2:200
Odd = 1:2:200
disp('---------------------------------------------------------------------------------------------------------')

%Problem 5 fixin' stuff

disp('Problem 5')
    
%D = [5:-5;100] should run from 5 to 100 in .5 increments

  D = [5:.5:100]    
  
%E = [5,25:100] should run from 5 to -100 in steps of -.25

  E = [5:-.25:-100]

%F, = linspace(-1,10.2,23) should run from 1 to 10 logarithmically over 
%20 values

format Long
F = logspace(1.0,10.0,20)
disp('---------------------------------------------------------------------------------------------------------')

%Problem 6

disp('Problem 6')
G = [1 2 3;4 5 6;7 8 9]
H = [11 12 13; 14 15 16; 17 18 19]
G(:,1) = H(3,:)
disp('---------------------------------------------------------------------------------------------------------')

%Problem 7

disp('Problem 7')
I = [1:10;11:20; 21:30]
J = I(1:3, 1:5)
k = J(2, 1:5)
disp('---------------------------------------------------------------------------------------------------------')

%Problem 8

disp('Problem 8')

L = zeros(1,4)
M = zeros(4,1)
N = cat(2,L,M')
O = cat(1,L',M)
disp('---------------------------------------------------------------------------------------------------------')

%Problem 9

disp('Problem 9')

Jack = [1:3:35]
Jill = [2:3:36]
Mary = zeros(1,12);
Mary(1,1:2:end) = Jack(1,1:2:end);
Mary(1,2:2:end) = Jill(1,2:2:end)

disp('---------------------------------------------------------------------------------------------------------')

%Problem 10

disp('Problem 10')

start_value = 1
step_value = 2
last_value = 80
Up = [start_value:step_value:last_value]
Down = [last_value-1:-step_value:start_value-1]

disp('---------------------------------------------------------------------------------------------------------')

%Problem 11

disp ('Problem 11')

x = linspace(0,1,200)
%xx = linspace(.5,1.5,200)
a = 6;
b = 6;
y = (x.^a).*((1-x).^b);


disp('---------------------------------------------------------------------------------------------------------')

%Problem 12

disp('Problem 12')
trial = [1:200]
base_rate = .25
learning_rate = .02
p_correct = base_rate + learning_rate * log(trial)

figure
plot(trial,p_correct,'-ob')
hold on 
grid on
title('Learning')
xlabel('Trials')
ylabel('Proportion Correct')
disp('------------------------------------------------------------------------------------------')
%Problem 13
clear, clc
%1st iteration

disp('Problem 13')
trial = [1:200]
base_rate = .25
learning_rate = .02
p_correct = base_rate + learning_rate * log(trial)

figure
plot(trial,p_correct,'-ob')
grid on
title('Learning')
xlabel('Trials')
ylabel('Proportion Correct')
hold on

%2nd iteration
learning_rate = .04
p_correct = base_rate + learning_rate * log(trial)

plot(trial, p_correct,'-oy')

%3rd iteration
learning_rate = .06
p_correct = base_rate + learning_rate * log(trial)

plot(trial, p_correct, '-ok')

%Problem 14


clear, clc
%Proportion correct W/.02 learning rate

disp('Problem 14')
trial = [1:200]
base_rate = .25
learning_rate = .02
p_correct = base_rate + learning_rate * log(trial)
total_correct = trial.* p_correct

figure
subplot(3,2,1)
plot(trial,p_correct,'-ob')
title('Learning')
ylim([0,.7])
xlabel('Trials')
ylabel('Proportion Correct')
hold on

%total correct @ .02 learning rate
subplot(3,2,2)
plot(trial, total_correct)
grid on
title('Learning')
xlabel('Trials')
ylabel('Total Correct')


%Proportaion correct W/ .04 learning rate
learning_rate = .04
p_correct = base_rate + learning_rate * log(trial)

subplot(3,2,3)
plot(trial,p_correct,'-oy')
title('Learning')
ylim([0,.7])
xlabel('Trials')
ylabel('Proportion Correct')
hold on

%total correct @ .04 learning rate
total_correct = trial.* p_correct
subplot(3,2,4)
plot(trial, total_correct)
grid on
title('Learning')
xlabel('Trials')
ylabel('Total Correct')


%Proportion correct W/ .06 learning rate
learning_rate = .06
p_correct = base_rate + learning_rate * log(trial)


subplot(3,2,5)
plot(trial,p_correct,'-ok')
title('Learning')
ylim([0,.7])
xlabel('Trials')
ylabel('Proportion Correct')
hold on

%total correct @ .06 learning rate
total_correct = trial.* p_correct

subplot(3,2,6)
plot(trial, total_correct)
grid on
title('Learning')
xlabel('Trials')
ylabel('Total Correct')

%Problem 15



clear, clc
%Proportion correct W/.02 learning rate
disp('Problem 15')
trial = [1:200]
base_rate = .25
learning_rate = .02
p_correct = base_rate + learning_rate * log(trial)
total_correct = trial.* p_correct

figure
subplot(3,2,1)
plot(trial,p_correct,'-ob')
title('Learning')
text(50,.1,'Learning rate = 0.02')
ylim([0,.7])
xlabel('Trials')
ylabel('Proportion Correct')
hold on

%total correct @ .02 learning rate
subplot(3,2,2)
plot(trial, total_correct)
grid on
title('Learning')
xlabel('Trials')
ylabel('Total Correct')


%Proportaion correct W/ .04 learning rate
learning_rate = .04
p_correct = base_rate + learning_rate * log(trial)

subplot(3,2,3)
plot(trial,p_correct,'-oy')
title('Learning')
text(50,.1,'Learning rate = 0.04')
ylim([0,.7])
xlabel('Trials')
ylabel('Proportion Correct')
hold on

%total correct @ .04 learning rate
total_correct = trial.* p_correct
subplot(3,2,4)
plot(trial, total_correct)
grid on
title('Learning')
xlabel('Trials')
ylabel('Total Correct')


%Proportion correct W/ .06 learning rate
learning_rate = .06
p_correct = base_rate + learning_rate * log(trial)


subplot(3,2,5)
plot(trial,p_correct,'-ok')
title('Learning')
text(50,.1,'Learning rate = 0.06')
ylim([0,.7])
xlabel('Trials')
ylabel('Proportion Correct')
hold on

%total correct @ .06 learning rate
total_correct = trial.* p_correct

subplot(3,2,6)
plot(trial, total_correct)
grid on
title('Learning')
xlabel('Trials')
ylabel('Total Correct')
