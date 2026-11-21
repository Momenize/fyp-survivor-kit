library ieee;
use ieee.std_logic_1164.all;

entity fulladder is
    port(
        cin, a, b: in std_logic;
        sum, cout: out std_logic);
end;

architecture behavioral of fulladder is
begin 
    sum <= a xor b xor cin; 
    cout <= (a and b) or (a and cin) or (b and cin);
end;