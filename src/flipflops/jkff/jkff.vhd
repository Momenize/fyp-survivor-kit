library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity jkff is 
    port(clk, j, k: in std_logic;
        q: buffer std_logic);
end entity;

architecture behavioral0 of jkff is
signal jk_combined: std_logic_vector(1 downto 0);
begin
    jk_combined <= j & k;
    process(clk)
    begin
        if(clk'event and clk = '0') then
            if(jk_combined = "00") then
                q <= q;
            elsif(jk_combined = "01") then
                q <= '0';
            elsif(jk_combined = "10") then
                q <= '1';
            else q <= not(q);
            end if;
        else q <= q;
        end if;
    end process;
end architecture;

                    
architecture behavioral1 of jkff is
    signal jk_combined: std_logic_vector(1 downto 0);
begin
    jk_combined <= j & k;
    process(clk)
    begin
        if(clk'event and clk = '0') then    
            case jk_combined is
                when("00") => q <= q;
                when("01") => q <= '0';
                when("10") => q <= '1';
                when("11") => q <= not(q);
            end case;
        end if;
    end process;
end architecture;

