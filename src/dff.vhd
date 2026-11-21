library ieee;
use ieee.std_logic_1164.all;

entity dff is 
    port(
        clk, d: in std_logic;
        q: buffer std_logic
    );
end;

architecture behavior of dff is
begin
    process(clk)
    begin
        if(clk'event and clk = '1') then
            q <= d;
        else
            q <= q;
        end if;
    end process;
end;

