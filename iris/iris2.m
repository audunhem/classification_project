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
W = randn(3,4);
a = 0.01;
N = 150;
x1all = [x1all ones(50,1) ones(50,1)];
x2all = [x2all ones(50,1) 2*ones(50,1)];
x3all = [x3all ones(50,1) 3*ones(50,1)];
x = [x1all ; x2all ; x3all];
x = [x(:,2:6)];

%training with gradient descent
for i = 1:1000
    dMSE = 0;
    for k = 1:N
        z_k = W*x(k,1:4)';
        g_k = zeros(3,1);
        t_k = zeros(3,1);
        t_k(x(k,5)) = 1;
        for j = 1:3
            g_k(j) = 1/(1+exp(-z_k(j)));
        end
        dMSE = dMSE + ((g_k-t_k).*g_k.*(1-g_k))*x(k,1:4);
    end
    W = W - a*dMSE;
end

error = 0;
for k = 1:150
    [~,I] = max(W*x(k,1:4)');
    if I ~= x(k,5)
        error = error +1;
    end
end

avg_error = error/150





    