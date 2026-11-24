library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
entity sp_sram is
  generic (
    DATA_WIDTH : integer := 8;
    DEPTH : integer := 32;
    ADDR_WIDTH : integer := 5
  );
  port (
    clk, rw, en     : in  std_logic;
    addr    : in  std_logic_vector(ADDR_WIDTH-1 downto 0);
    data    : inout std_logic_vector(DATA_WIDTH-1 downto 0)
  );
end entity sp_sram;

architecture rtl of sp_sram is
  type ram_type is array (0 to DEPTH-1) of std_logic_vector(DATA_WIDTH-1 downto 0);
  signal ram : ram_type := (others => (others => '0'));
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if(en = '1') then
                if rw = '0' then
                    ram(conv_integer(unsigned(addr))) <= data;
                elsif rw = '1' then
                    data <= ram(conv_integer(unsigned(addr)));  
                end if;
            end if;
        end if;
    end process;
end architecture;
