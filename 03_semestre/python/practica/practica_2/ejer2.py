from collections import Counter
from ejer1 import content_as_string

words = content_as_string.lower().split()

most_used_word = Counter(words).most_common(1)[0]
print(f'{most_used_word = }')
