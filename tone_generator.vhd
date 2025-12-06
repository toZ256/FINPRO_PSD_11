library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tone_generator is
    Port ( 
        clk         : in  STD_LOGIC;
        reset       : in  STD_LOGIC;
        enable_tone : in  STD_LOGIC; 
        divisor     : in  INTEGER; 
        wave_out    : out STD_LOGIC
    );
end tone_generator;

architecture Behavioral of tone_generator is
    signal count : integer range 0 to 50000000 := 0;
    signal temp_wave : std_logic := '0';
begin
    process(clk, reset)
    begin
        if reset = '1' then
            count <= 0;
            temp_wave <= '0';
        elsif rising_edge(clk) then
            if enable_tone = '1' and divisor > 0 then
                if count >= divisor then
                    temp_wave <= not temp_wave;
                    count <= 0;
                else
                    count <= count + 1;
                end if;
            else
                temp_wave <= '0';
                count <= 0;
            end if;
        end if;
    end process;
    wave_out <= temp_wave;
end Behavioral;