function c_ber=ber(x, x_ref, bps)
persistent t_bits e_bits;
if nargin==0
    e_bits=0; t_bits=0; c_ber=0;
    % e_bits: # ~
elseif nargin==3
    for ii=1:length(x)
        e_bits = e_bits + error_check(bitxor(x(ii), x_ref(ii)), bps);
    end
    t_bits = t_bits + length(x) * bps; c_ber = e_bits/t_bits;
end
return;

function ecount=error_check(x_xor, bps)
ecount=0;
for ii=0:bps-1, ecount=ecount+bitand(bitshift(x_xor, -ii), 1); end