library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
entity sp_sram_tb is
-- Testbenches have an empty entity
end entity;

architecture sim of sp_sram_tb is
    -- Signals to drive and monitor the Unit Under Test (UUT)
    signal tb_clk    : std_logic := '0';
    signal tb_en    : std_logic := '0';
    signal tb_rw  : std_logic := '0';
    signal tb_addr : std_logic_vector(4 downto 0) := (others => '0');
    signal tb_data : std_logic_vector(7 downto 0) := (others => '0');

    type ram_type is array (0 to 31) of std_logic_vector(7 downto 0);
    signal ram : ram_type := (
        0 => "00000000",
        1 => "00000001",
        2 => "00000010",
        3 => "00000011",
        4 => "00000100",
        5 => "00000101",
        6 => "00000110",
        7 => "00000111",
        8 => "00001000",
        9 => "00001001",
        10 => "00001010",
        11 => "00001011",
        12 => "00001100",
        13 => "00001101",
        14 => "00001110",
        15 => "00001111",
        16 => "00010000",
        17 => "00010001",
        others => "11111111"
    );
    
begin

    -- Instantiate the halfadder directly using 'entity work'
    UUT: entity work.sp_sram
        port map (
            clk => tb_clk,
            rw => tb_rw,
            en => tb_en,
            addr => tb_addr,
            data => tb_data
        );

    -- Stimulus process to test all input combinations
    stim_proc: process
    begin
        tb_clk <= '0'; 
        tb_rw <= '0'; 
        tb_en <= '1'; 
        wait for 10 ns;

        tb_clk <= '1'; 
        tb_rw <= '0'; 
        tb_en <= '1'; 
        tb_addr <= "00010";
        wait for 10 ns;

        tb_clk <= '0'; 
        tb_rw <= '1'; 
        tb_en <= '0'; 
        tb_addr <= "10011"; 
        tb_data <= "00011111";
        wait for 10 ns;

        tb_clk <= '1'; 
        tb_rw <= '1'; 
        tb_en <= '1'; 
        tb_addr <= "00010"; 
        tb_data <= "10101010";
        wait for 10 ns;

        tb_clk <= '0'; 
        tb_rw <= '0'; 
        tb_en <= '1'; 
        tb_addr <= "00011"; 
        tb_data <= "00011111";
        wait for 10 ns;

        tb_clk <= '1'; 
        tb_rw <= '0'; 
        tb_en <= '1'; 
        tb_addr <= "01001";
        wait for 10 ns;
    end process;

end architecture;