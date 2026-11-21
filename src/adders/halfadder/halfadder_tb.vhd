library ieee;
use ieee.std_logic_1164.all;

entity halfadder_tb is
-- Testbenches have an empty entity
end entity;

architecture sim of halfadder_tb is
    -- Signals to drive and monitor the Unit Under Test (UUT)
    signal tb_a    : std_logic := '0';
    signal tb_b    : std_logic := '0';
    signal tb_sum  : std_logic;
    signal tb_cout : std_logic;
begin

    -- Instantiate the halfadder directly using 'entity work'
    UUT: entity work.halfadder
        port map (
            a    => tb_a,
            b    => tb_b,
            sum  => tb_sum,
            cout => tb_cout
        );

    -- Stimulus process to test all input combinations
    stim_proc: process
    begin
        -- 0 + 0
        tb_a <= '0'; tb_b <= '0';
        wait for 10 ns;

        -- 0 + 1
        tb_a <= '0'; tb_b <= '1';
        wait for 10 ns;

        -- 1 + 0
        tb_a <= '1'; tb_b <= '0';
        wait for 10 ns;

        -- 1 + 1
        tb_a <= '1'; tb_b <= '1';
        wait for 10 ns;

        -- Stop simulation loop
        wait;
    end process;

end architecture;