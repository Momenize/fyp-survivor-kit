library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity rom is
  port (
    clk    : in  std_logic;
    reset  : in  std_logic;
    enable : in  std_logic;
    addr   : in  std_logic_vector(4 downto 0);
    data   : out std_logic_vector(7 downto 0)
  );
end entity rom;

architecture behavioral of rom is
  type rom_type is array (0 to 31) of std_logic_vector(7 downto 0);

  constant rom_content : rom_type := (
    0  => x"7C",
    1  => x"6D",
    2  => x"B5",
    3  => x"62",
    4  => x"4B",
    5  => x"2F",
    6  => x"CC",
    7  => x"FE",
    8  => x"C5",
    9  => x"B2",
    10 => x"7D",
    11 => x"20",
    12 => x"CD",
    13 => x"BA",
    14 => x"EC",
    15 => x"8F",
    16 => x"65",
    17 => x"6F",
    18 => x"DF",
    19 => x"EF",
    others => x"00"
  );
begin
  process(clk, reset)
  begin
    -- Asynchronous reset: checked before the clock edge
    if reset = '1' then
      data <= (others => 'Z');
    -- Low-edge-sensitive clock
    elsif falling_edge(clk) then
      -- Synchronous enable: checked after the clock edge
      if enable = '1' then
        data <= rom_content(conv_integer(unsigned(addr)));
      end if;
    end if;
  end process;
end architecture behavioral;
