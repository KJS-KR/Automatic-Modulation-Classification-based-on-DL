net = squeezenet;

a = 5;

exportONNXNetwork(net,"a" + a + ".onnx");

% importNet = importONNXNetwork('a.onnx');