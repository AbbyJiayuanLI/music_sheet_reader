# music_sheet_reader
This is a MATLAB based music sheet reader that can automatically recognize different kinds of music sheet and generate music accordingly. (temporal description)

# Project Structure
* Read Image
* **Segmentation and Preprocessing**
  * Binarization
  * Staff line detection and removal
* **Object Recognition**
  * Interval Splitting
  * Notes Splitting
  * Clef Identification
  * Key Identification
  * Note Detection
* **Audio Synthesis**

# Division of Work
* Jiayuan Li


# Milestones
* Initial Demo with function of:
  * recognize the key, notes of piano sheet
  * Audio generation with any sound in the correct key
  
* Additional feature to be added:
  * recognition of clef
  * recognition of tempo
  * recognize different kinds of sheet. For example, piano, violin(not different from piano sheet), guitar...
  * automatic choosing of different instrument according to type of sheet
  * generate difference instrument sounds (piano, violin, guitar...)
  * generate audio with midi file output
  
