FILE_NAME = "dictionary.txt"
letter_dist= {
    "a": 14.492949,
    "b": 2.931469,
    "c": 0.912545,
    "d": 2.019922,
    "e": 10.593054,
    "f": 0.550071,
    "g": 4.662511,
    "h": 1.51226,
    "i": 7.148434,
    "j": 0.834961,
    "k": 5.594015,
    "l": 3.885425,
    "m": 5.468035,
    "n": 9.955171,
    "o": 3.491769,
    "p": 3.44936,
    "q": 0.005239,
    "r": 6.242625,
    "s": 4.626338,
    "t": 4.828655,
    "u": 4.631078,
    "v": 0.191839,
    "w": 0.445545,
    "x": 0.007235,
    "y": 0.797541,
    "z": 0.09779
}
class Dictionary:
    def __init__(self):
        self.dictionary = []
        self.dictionary_length = 0

    def load_dictionary(self):
        with open(FILE_NAME, "r") as f:
            for line in f:
                self.dictionary.append(line.strip())
                self.dictionary_length += 1

    def lookup_word(self, word):
        if self.dictionary_length < 1: return False
        left = 0 
        right = self.dictionary_length
        while left != right:
            middle = (left + right) // 2
            if (middle == left): break
            if word < self.dictionary[middle]:
                right = middle
            elif word > self.dictionary[middle]:
                left = middle
            else: return True
        return word == self.dictionary[left]

if __name__ == "__main__" :
    dictionary = Dictionary()
    dictionary.load_dictionary()
    print(dictionary.dictionary_length)
    print(dictionary.lookup_word("pamit"))
    print(dictionary.lookup_word("amit"))