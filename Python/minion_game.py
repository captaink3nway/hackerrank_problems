def minion_game(string):
    string = list(string)
    vowel_poss_words = 0
    consonant_poss_words = 0
    vowel_score = 0
    consonant_score = 0
    vowel_sub_string=[] 
    consonant_sub_string=[]

    for ch in range(0, len(string)):
        if string[ch]=='A' or string[ch]=='E' or string[ch]=='I' or string[ch]=='O' or string[ch]=='U':
            vowel_sub_string.append(string[ch])
        else:
            consonant_sub_string.append(string[ch])
    
    consonant_sub_string = list(dict.fromkeys(consonant_sub_string))
    vowel_sub_string = list(dict.fromkeys(vowel_sub_string))
    
    for co in range(0, len(consonant_sub_string)):
        for ch in range(0, len(string)):
            if(string[ch]==consonant_sub_string[co]):
                consonant_poss_words = len(string) - ch
                consonant_score = consonant_score + consonant_poss_words
            else: continue
    
    for cv in range(0, len(vowel_sub_string)):
        for ch in range (0, len(string)):
            if(string[ch]==vowel_sub_string[cv]):
                vowel_poss_words = len(string) - ch
                vowel_score = vowel_score + vowel_poss_words
            else: continue
    
    if (consonant_score > vowel_score):
        print ("Stuart {}".format(consonant_score))
    elif (vowel_score > consonant_score):
        print ("Kevin {}".format(vowel_score))
    else: print ("Draw")

if __name__ == '__main__':
    s = input()
    minion_game(s)