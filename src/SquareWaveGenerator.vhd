library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

entity SqaureWaveGenerator is 
    port (
    i_clk_50MHz   : in  std_ulogic;
    i_nrst_async  : in  std_ulogic;
    i_enable      : in  std_ulogic;
    i_note_select : in  unsigned(3 downto 0);
    o_wave        : out std_ulogic
    );
end entity SqaureWaveGenerator;

architecture RTL of SqaureWaveGenerator is 
    signal state : std_ulogic := '0';
    signal count : integer := 0;
    signal note_select_sync : integer := 0;
    signal done : std_ulogic := '0';

    -- note_period = (system_clk_frequency)/(2 x target_frequency) and rounding it to the nearest integer 

    type note_array is array (0 to 15) of integer;
    constant note_periods : note_array := (
    95555, -- C4 (261.63 Hz)
    85132, -- D4 (293.66 Hz)
    75843, -- E4 (329.63 Hz)
    71586, -- F4 (349.23 Hz)
    63776, -- G4 (392.00 Hz)
    56818, -- A4 (440.00 Hz)
    50620, -- B4 (493.88 Hz)
    47778, -- C5 (523.25 Hz)
    42566, -- D5 (587.33 Hz)
    37922, -- E5 (659.25 Hz)
    35793, -- F5 (698.46 Hz)
    31888, -- G5 (783.99 Hz)
    28409, -- A5 (880.00 Hz)
    25310, -- B5 (987.77 Hz)
    23889, -- C6 (1046.50 Hz)
    21283  -- D6 (1174.66 Hz)
    );

begin 
    proc_squarewave : process(i_clk_50MHz,i_nrst_async) is 
    begin 
    if (i_nrst_async = '0') then
        state <= '0';
        count <= 0;
    elsif (rising_edge(i_clk_50MHz)) then 
        if (i_enable = '0') then
            state <= '0';
            count <= 0;
        elsif (i_enable = '1') then 
            if (done = '0') then 
                note_select_sync <= to_integer(i_note_select);
                done <= '1';
            end if;
            if (count = note_periods(note_select_sync)) then 
                state <= not state;
                count <= 0;
                done <= '0';
            else 
                count <= count + 1;
            end if;
        end if;
    end if;
    end process proc_squarewave;
    o_wave <= state;
end architecture RTL;

