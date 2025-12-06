library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity audio_mixer is
    Port (
        clk      : in STD_LOGIC;
        channels : in STD_LOGIC_VECTOR(3 downto 0); -- Changed from wave_array to std_logic_vector for simplicity in interface, or keep wave_array if defined in pkg
        audio_out: out STD_LOGIC
    );
end audio_mixer;

architecture Behavioral of audio_mixer is
begin
    -- Simple mixing: ORing the channels
    -- Ideally this would be a PWM mixer for better quality, but for 1-bit output, OR is standard for simple buzzers
    process(clk)
    begin
        if rising_edge(clk) then
            audio_out <= channels(0) or channels(1) or channels(2) or channels(3);
        end if;
    end process;
end Behavioral;
