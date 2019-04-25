close all

x1all = load('class_1','-ascii');
x2all = load('class_2','-ascii');
x3all = load('class_3','-ascii');

% Histograms of all four features
figure()
hold on
subplot(2,2,1)
hist([x1all(:,1),x2all(:,1),x3all(:,1)]);
title('Feature 1')

subplot(2,2,2)
hist([x1all(:,2),x2all(:,2),x3all(:,2)]);
title('Feature 2')

subplot(2,2,3)
hist([x1all(:,3),x2all(:,3),x3all(:,3)]);
title('Feature 3')

subplot(2,2,4)
hist([x1all(:,4),x2all(:,4),x3all(:,4)]);
title('Feature 4')
hold off

%inserting one column of ones for the offset, and one column with the 
%target class
x1all = [x1all ones(50,1) ones(50,1)];
x2all = [x2all ones(50,1) 2*ones(50,1)];
x3all = [x3all ones(50,1) 3*ones(50,1)];
x = [x1all ; x2all ; x3all];

a = 0.01; %learning rate
N = size(x,1);
feat = [3:6]; %defining which features are used
x = [x(:,feat)]; %removing undesired features from x
W = zeros(3,p);  %initializing weight matrix as zeroes

h = size(feat,2);
p = h-1;

%vector of training and test samples 
x_train = [x1all(1:30,feat) ; x2all(1:30,feat) ; x3all(1:30,feat)];
x_test = [x1all(31:50,feat) ; x2all(31:50,feat) ; x3all(31:50,feat)];


%training with gradient descent
for i = 1:1000
    %initializing the gradient
    dMSE = 0;
    
    %iterate through the training samples
    for k = 1:size(x_train,1)
        z_k = W*x_train(k,1:p)';
        g_k = zeros(3,1);
        t_k = zeros(3,1);
        t_k(x_train(k,h)) = 1;
        for j = 1:3
            g_k(j) = 1/(1+exp(-z_k(j)));
        end
        %calculate gradient
        dMSE = dMSE + ((g_k-t_k).*g_k.*(1-g_k))*x_train(k,1:p);
    end
    W = W - a*dMSE;
end

%calculate training errors
error = 0;
for k = 1:size(x_train,1)
    [~,I] = max(W*x_train(k,1:p)');
    if I ~= x_train(k,h)
        error = error +1;
    end
end
avg_error = error/size(x_train,1)

%creating the confusion matrix
error = 0;
confm = zeros(3);
for k = 1:size(x_test,1)
    [~,I] = max(W*x_test(k,1:p)');
    confm(x_test(k,h),I) = confm(x_test(k,h),I) + 1;
    if I ~= x_test(k,h)
            error = error +1;
    end
end
m = confm




    
