x1all = load('class_1','-ascii');
x2all = load('class_2','-ascii');
x3all = load('class_3','-ascii');

%g = W*x + w_0;
%W := [W w_0] (4x4)
W = randn(3,5);
a = 0.05;
N = 150;
x1all = [x1all ones(50,1) ones(50,1)];
x2all = [x2all ones(50,1) 2*ones(50,1)];
x3all = [x3all ones(50,1) 3*ones(50,1)];
x_train = [x1all(1:30,:) ; x2all(1:30,:) ; x3all(1:30,:)];
x_test = [x1all(31:50,:) ; x2all(31:50,:) ; x3all(31:50,:)];

%training with gradient descent
for i = 1:10000
    dMSE = 0;
    for k = 1:90
        z_k = W*x_train(k,1:5)';
        g_k = zeros(3,1);
        t_k = zeros(3,1);
        t_k(x_train(k,6)) = 1;
        for j = 1:3
            g_k(j) = 1/(1+exp(-z_k(j)));
        end
        dMSE = dMSE + ((g_k-t_k).*g_k.*(1-g_k))*x_train(k,1:5);
    end
    W = W - a*dMSE;
end

error = 0;
confm = zeros(3);
for k = 1:60
    [~,I] = max(W*x_test(k,1:5)');
    if I ~= x_test(k,6)
        error = error +1;
    end
    confm(x_test(k,6),I) = confm(x_test(k,6),I) + 1;
end

avg_error = error/60





    