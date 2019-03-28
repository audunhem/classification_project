close all

x1all = load('class_1','-ascii');
x2all = load('class_2','-ascii');
x3all = load('class_3','-ascii');

figure()
hist([x1all(:,1),x2all(:,1),x3all(:,1)]);
title('Feature 1')

figure()
hist([x1all(:,2),x2all(:,2),x3all(:,2)]);
title('Feature 2')

figure()
hist([x1all(:,3),x2all(:,3),x3all(:,3)]);
title('Feature 3')

figure()
hist([x1all(:,4),x2all(:,4),x3all(:,4)]);
title('Feature 4')

%g = W*x + w_0;
%W := [W w_0] (4x4)
n_rem_feat = 2;
W = zeros(3,5-n_rem_feat); %initializing weight matrix as zeroes

%inserting one column of ones for the offset, and one column with the 
%target class
x1all = [x1all ones(50,1) ones(50,1)];
x2all = [x2all ones(50,1) 2*ones(50,1)];
x3all = [x3all ones(50,1) 3*ones(50,1)];

%vector of training and test samples

x_train = [x1all(1:30,:) ; x2all(1:30,:) ; x3all(1:30,:)];
x_test = [x1all(31:50,:) ; x2all(31:50,:) ; x3all(31:50,:)];
x_train = [x_train(:,3:6)];
x_test = [x_test(:,3:6)];
error_train = []; %vector of training error for each iteration
a = 0.001; %learning rate
i = 1;

%training with gradient descent
while true
    %initializing the gradient and the training error
    dMSE = 0;
    error = 0;
    
    %iterate through the training samples
    for k = 1:90
        z_k = W*x_train(k,1:5-n_rem_feat)';
        g_k = zeros(3,1);
        t_k = zeros(3,1);
        t_k(x_train(k,6-n_rem_feat)) = 1;
        for j = 1:3
            g_k(j) = 1/(1+exp(-z_k(j)));
        end
        %calculate gradient
        dMSE = dMSE + ((g_k-t_k).*g_k.*(1-g_k))*x_train(k,1:5-n_rem_feat);
        
        %calculate training errors
        [~,I] = max(W*x_train(k,1:5-n_rem_feat)');
        if I ~= x_train(k,6-n_rem_feat)
            error = error +1;
        end
    end
    W = W - a*dMSE;
    
    %calculate average training error for each iteration
    error_train = [error_train error/90];
    
    %stop if validation error increades for five consecutive iterations
    if i >= 100 && sum(error_train(i) > error_train(i-5:i-1)) == 5 || i == 10000
        break
    end
    i = i + 1;
end

error = 0;
confm = zeros(3);
for k = 1:60
    [~,I] = max(W*x_test(k,1:5-n_rem_feat)');
    confm(x_test(k,6-n_rem_feat),I) = confm(x_test(k,6-n_rem_feat),I) + 1;
    if I ~= x_test(k,6-n_rem_feat)
            error = error +1;
    end
end

%plotting the training error for each iteration
figure()
plot(1:length(error_train),error_train)

%average test error
avg_error = error/60
confm





    