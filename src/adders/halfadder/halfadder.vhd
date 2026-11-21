library ieee;
use ieee.std_logic_1164.all;


entity halfadder is
    port(a, b: in std_logic;
        sum, cout: out std_logic);
end entity;

architecture bhv of halfadder is
begin
    sum <= a xor b;
    cout <= a and b;
end;
