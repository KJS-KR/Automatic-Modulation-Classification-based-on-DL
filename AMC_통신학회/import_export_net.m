

% orderNet = "3Type_Order_SNR=-4_SPF_12.onnx";
% 
% net = importONNXNetwork(orderNet);
% 
% analyzeNetwork(net)

squeezeNet = squeezenet;
exportONNXNetwork(squeezeNet,"squeezeNet.onnx");

modelfile = "squeezeNet.onnx";
net = importONNXNetwork(modelfile);