# Paprika

__Bash Script to encipher all photos in the current directory using any given pass-file.__


## Usage:

```$ bash paprika.sh # in the same directory as the pictures ```

You need to run this script in the same directory as your photos. So, a way would
be to have this script copied into the required directory and do ```$ bash paprika.sh```
there.

For those who want to keep this in one of the directories in the PATH variable ---
that's a good idea too.

** Make sure you have the pass-file in the same directory, too. ** It needs to be ready
before you run the script. (Please never use an empty file as the pass file. Nor
use the script itself as the pass file. Anyone would be able to guess those.)

## Note:
 If you're not using a text-file as the pass-file, keep it safe and hidden some-
where.<br /> If you're using a text file and you can remember everything in the file (including the white-spaces), you can delete the text file and then make a new one at decryption time.
A safer way would be to just encrypt the pass-file and keep it hidden somewhere.
Please make sure your text pass-file isn't easily guessable, by humans __or computers__.

__*Since the script deletes all the original photos after encrypting them, DO
NOT EVER USE ONE OF THE PICTURES AS THE PASS-FILE!*__



P. S: Not quite sure if having such sensitive photos is a very good idea in this day
and age. <br />
P. P. S: Putting the sensitive photos in an off-line medium after encryption is advised.
Off-line medium as in a pen-drive that you'd never use in a computer that is connected
to The Internet.
