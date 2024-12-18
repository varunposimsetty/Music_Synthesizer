library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

entity tb is 
end entity tb;

architecture bhv of tb is
    signal clk : std_ulogic := '0';
    signal rst : std_ulogic := '0';
    signal enable : std_ulogic := '0';
    signal note_select : unsigned(3 downto 0) := (others => '0');
    signal wave_out : std_ulogic;

    begin 

        DUT_SquareWaveGen : entity work.SqaureWaveGenerator(RTL)
            port map(
                i_clk_50MHz => clk,
                i_nrst_async => rst,
                i_enable => enable,
                i_note_select => note_select,
                o_wave => wave_out
            );
        
        proc_clock_gen : process is
            begin
                wait for 10 ns;
                clk <= not clk;
        end process proc_clock_gen;

        proc_tb : process is 
                begin 
                    wait for 1250 ns;
                    rst <= '1';
                    wait for 200000 ns;
                    enable <= '1';
                    wait for 2000000 ns;
                    note_select <= "0001";
                    wait for 2000000 ns;
                    note_select <= "0010";
                    wait for 2000000 ns;
                    note_select <= "0011";
                    wait for 2000000 ns;
                    note_select <= "0100";
                    wait for 2000000 ns;
                    enable <= '0';
                    wait for 2000 ns;
                    enable <= '1';
                    wait for 2000000 ns;
                    note_select <= "0101";
                    wait for 2000000 ns;
                    note_select <= "0110";
                    wait for 2000000 ns;
                    note_select <= "0111";
                    wait for 2000000 ns;
                    note_select <= "1000";
                    wait for 2000000 ns;
                    wait;
        end process proc_tb;
end architecture bhv;


