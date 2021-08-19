
class Spotify:
    def __init__(self, path):
        self.path = path
        self.track_name = []
        self.artist_name = []
        self.genre = []
        self.beats_per_minute = []
        self.energy = []
        self.danceability = []
        self.loudness = []
        self.liveness = []
        self.valence = []
        self.length = []
        self.acousticness = []
        self.speechiness = []
        self.popularity = []
        self.colaboration = []
        self.year_of_birth = []
        self.age = []
        self.musical_gender = []
        self.song_size = []
        self.initialize()

    def initialize(self):
        file = self.open_file_for_read(self.path)
        line = file.readline().split()

        while True:
            line = file.readline().split()
            if len(line) == 0:
                break
    
            self.track_name.append(line[0])
            self.artist_name.append(line[1])
            self.genre.append(line[2])
            self.beats_per_minute.append(line[3])
            self.energy.append(line[4])
            self.danceability.append(line[5])
            self.loudness.append(line[6])
            self.liveness.append(line[7])
            self.valence.append(line[8])
            self.length.append(line[9])
            self.acousticness.append(line[10])
            self.speechiness.append(line[11])
            self.popularity.append(line[12])
            self.colaboration.append(line[13])
            self.year_of_birth.append(line[14])
            self.age.append(line[15])
            self.musical_gender.append(line[16])
            self.song_size.append(line[17])

        self.close_file(file)
    
    def open_file_for_read(self, path):
        file = open(path, 'r')
        return file

    def open_file_for_write(self, path):
        file = open(path, 'w')
        return file

    def open_file_for_read_and_write(self, path):
        file = open(path, 'r+')
        return file
    
    def close_file(self, file):
        file.close()

def get_median(list):
    sum = 0
    for i in list:
        sum += int(i)
    return sum // len(list)

def checker_age(list1, list2):
    print('CHEQUENADO LA COLUMNA AGE')
    young, adult, other = 0, 0, 0
    for i in range (0, len(list1)):
        year = int(list1[i])
        string = 'JOVEN' if year >= 1993 else 'ADULTO'
        if list2[i] == 'JOVEN':
            young += 1
        elif list2[i] == 'ADULTO':
            adult += 1
        else:
            other += 1
        if string != list2[i]:
            print(f'DICE {list2[i]} Y DEBERIA DECIR {string}')
        else:
            print('CORRECTO')
    print(f'HAY {young} JOVENES, {adult} ADULTOS Y {other} OTROS')

def checker_song_size(list1, list2):
    print('CHEQUENADO LA COLUMNA SONG_SIZE')
    short, large, other = 0, 0, 0
    for i in range (0, len(list1)):
        length = int(list1[i])
        string = 'LARGA' if length >= 198 else 'CORTA'
        if list2[i] == 'CORTA':
            short += 1
        elif list2[i] == 'LARGA':
            large += 1
        else:
            other += 1
        if string != list2[i]:
            print(f'DICE {list2[i]} Y DEBERIA DECIR {string}')
        else:
            print('CORRECTO')
    print(f'HAY {short} CORTAS, {large} LARGAS Y {other} OTRAS')

def checker_colaboration(list):
    yes, no, other = 0, 0, 0
    for i in list:
        if i == 'SI':
            yes += 1
        elif i == 'NO':
            no += 1
        else:
            other += 1
    print(f'HAY {yes} SI, {no} NO Y {other} OTROS')

def checker_musical_gender(list):
    pop, reggaeton, other = 0, 0, 0
    for i in list:
        if i == 'POP':
            pop += 1
        elif i == 'REGGAETON':
            reggaeton += 1
        else:
            other += 1
    print(f'HAY {pop} POP, {reggaeton} REGGAETON Y {other} OTROS')

def Main():

    spotify = Spotify('top50.txt')

    median_year_of_birth = get_median(spotify.year_of_birth)
    median_length = get_median(spotify.length)
    # print(f'MEDIA DEL ANNO = {median_year_of_birth} , MEDIA DE LA LONGITUD = {median_length}')

    # checker_song_size(spotify.length, spotify.song_size)
    # checker_age(spotify.year_of_birth, spotify.age)
    checker_colaboration(spotify.colaboration)
    checker_musical_gender(spotify.musical_gender)

if __name__ == "__main__":
    Main()
    