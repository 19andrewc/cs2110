/**
 * @file hw7.c
 * @author Austin Peng
 * @brief structs, pointers, pointer arithmetic, arrays, strings, and macros
 * @date 2021-11-02
 */

// DO NOT MODIFY THE INCLUDE(S) LIST
#include <stdio.h>
#include "hw7.h"
#include "my_string.h"

// Global array of pokemon structs
struct pokemon pokedex[MAX_POKEDEX_SIZE];

int size = 0;

/** catchPokemon
 *
 * @brief creates a new pokemon struct and adds it to the array of pokemon structs, "pokedex"
 *
 *
 * @param "nickname" nickname of the pokemon being created and added
 *               NOTE: if the length of the nickname (including the null terminating character)
 *               is above MAX_NICKNAME_SIZE, truncate nickname to MAX_NICKNAME_SIZE. If the length
 *               is below MIN_NICKNAME_SIZE, return FAILURE.  
 *               
 * @param "pokedexNumber" pokedexNumber of the pokemon being created and added
 * @param "powerLevel" power level of the pokemon being created and added
 * @param "speciesName" species name of the pokemon being created and added
 * @return FAILURE on failure, SUCCESS on success
 *         Failure if any of the following are true:
 *         (1) "nickname" is less than MIN_NICKNAME_SIZE
 *         (2) a pokemon with the same already exits in the array "pokedex"
 *         (3) adding the new pokemon would cause the size of the array "pokedex" to
 *             exceed MAX_POKEDEX_SIZE
 */
int catchPokemon(const char *nickname, int pokedexNumber, double powerLevel, const char *speciesName)
{
  // nicknameLength = minimum(MAX_NICKNAME_SIZE, nicknameLength)
  long unsigned int nicknameLength = my_strlen(nickname);
  if (nicknameLength < MIN_NICKNAME_SIZE) {
    return FAILURE;
  } else if (nicknameLength > MAX_NICKNAME_SIZE) {
    nicknameLength = MAX_NICKNAME_SIZE - 1;
  }

  // speciesNameLength must be greater than MIN_SPECIESNAME_LENGTH
  long unsigned int speciesNameLength = my_strlen(speciesName);
  if (speciesNameLength < MIN_SPECIESNAME_SIZE) {
    return FAILURE;
  }

  // if size is at pokedex capacity -> return failure
  // if any name in the pokedex is same as the one being caught -> return failure
  // otherwise add pokemon -> return success
  int i = 0;
  if (size >= MAX_POKEDEX_SIZE) {
    return FAILURE;
  } else {
    while (i < size) {
      if (my_strlen(pokedex[i].nickname) == nicknameLength && my_strncmp(pokedex[i].nickname, nickname, nicknameLength) == 0) {
        return FAILURE;
      }
      i++;
    }
    my_strncpy(pokedex[size].nickname, nickname, MAX_NICKNAME_SIZE - 1);
    pokedex[size].pokedexNumber = pokedexNumber;
    pokedex[size].powerLevel = powerLevel;
    my_strncpy(pokedex[size].speciesName, speciesName, MAX_SPECIESNAME_SIZE - 1);
    size++;
  }
  return SUCCESS;
}

/** updatePokemonNickname
 *
 * @brief updates the nickname of an existing pokemon in the array of pokemon structs, "pokedex"
 *
 * @param "s" pokemon struct that exists in the array "pokedex"
 * @param "nickname" new nickname of pokemon "s"
 *               NOTE: if the length of nickname (including the null terminating character)
 *               is above MAX_NICKNAME_SIZE, truncate nickname to MAX_NICKNAME_SIZE
 * @return FAILURE on failure, SUCCESS on success
 *         Failure if any of the following are true:
 *         (1) the pokemon struct "s" can not be found in the array "pokedex"
 */
int updatePokemonNickname(struct pokemon s, const char *nickname)
{
  long unsigned int nicknameLength = my_strlen(nickname);
  if (nicknameLength < MIN_NICKNAME_SIZE) {
    return FAILURE;
  } else if (nicknameLength > MAX_NICKNAME_SIZE) {
    nicknameLength = MAX_NICKNAME_SIZE - 1;
  }

  int i = 0;
  while (i < size) {
    if (my_strncmp(pokedex[i].nickname, s.nickname, my_strlen(s.nickname)) == 0) {
      my_strncpy(pokedex[i].nickname, nickname, MAX_NICKNAME_SIZE - 1);
      return SUCCESS;
    }
    i++;
  }
  return FAILURE;
}

/** swapPokemon
 *
 * @brief swaps the position of two pokemon structs in the array of pokemon structs, "pokedex"
 *
 * @param "index1" index of the first pokemon struct in the array "pokedex"
 * @param "index2" index of the second pokemon struct in the array "pokedex"
 * @return FAILURE on failure, SUCCESS on success
 *         Failure if any of the following are true:
 *         (1) "index1" and/or "index2" are negative numbers
 *         (2) "index1" and/or "index2" are out of bounds of the array "pokedex"
 */
int swapPokemon(int index1, int index2)
{
  if (index1 < 0 || index2 < 0 || index1 >= size || index2 >= size) {
    return FAILURE;
  }
  struct pokemon temp = pokedex[index1];
  pokedex[index1] = pokedex[index2];
  pokedex[index2] = temp;

  // // copy index2 into index1
  // my_strncpy(pokedex[index1].nickname, pokedex[index2].nickname, my_strlen(pokedex[index2].nickname));
  // pokedex[index1].pokedexNumber = pokedex[index2].pokedexNumber;
  // pokedex[index1].powerLevel = pokedex[index2].powerLevel;
  // my_strncpy(pokedex[index1].speciesName, pokedex[index2].speciesName, my_strlen(pokedex[index2].speciesName));

  // // copy temp into index 2
  // my_strncpy(pokedex[index2].nickname, temp.nickname, my_strlen(temp.nickname));
  // pokedex[index2].pokedexNumber = temp.pokedexNumber;
  // pokedex[index2].powerLevel = temp.powerLevel;
  // my_strncpy(pokedex[index2].speciesName, temp.speciesName, my_strlen(temp.speciesName));

  return SUCCESS;
}

/** releasePokemon
 *
 * @brief removes pokemon in the array of pokemon structs, "pokedex", that has the same nickname
 *
 * @param "s" pokemon struct that exists in the array "pokedex"
 * @return FAILURE on failure, SUCCESS on success
 *         Failure if any of the following are true:
 *         (1) the pokemon struct "s" can not be found in the array "pokedex"
 */
int releasePokemon(struct pokemon s)
{
  int i = 0;
  while (i < size) {
    if (my_strlen(pokedex[i].nickname) == my_strlen(s.nickname) && my_strncmp(pokedex[i].nickname, s.nickname, my_strlen(s.nickname)) == 0) {
      while (i < size) {
        pokedex[i] = pokedex[i + 1];
        i++;
      }
      size--;
      return SUCCESS;
    }
    i++;
  }

  return FAILURE;
}

/** comparePokemon
 *
 * @brief compares the two pokemons' pokedex number and names (using ASCII)
 *
 * @param "s1" pokemon struct that exists in the array "pokedex"
 * @param "s2" pokemon struct that exists in the array "pokedex"
 * @return negative number if s1 is less than s2, positive number if s1 is greater
 *         than s2, and 0 if s1 is equal to s2
 */
int comparePokemon(struct pokemon s1, struct pokemon s2)
{
  if (s1.pokedexNumber == s2.pokedexNumber) {
    long unsigned int largerNicknameLength = my_strlen(s1.nickname);
    if (largerNicknameLength < my_strlen(s2.nickname)) {
      largerNicknameLength = my_strlen(s2.nickname);
    }
    return my_strncmp(s1.nickname, s2.nickname, largerNicknameLength);
  }
  return s1.pokedexNumber - s2.pokedexNumber;
}

/** sortPokemon
 *
 * @brief using the comparePokemon function, sort the pokemons in the array of
 * pokemon structs, "pokedex," by the pokedex number and nicknames
 *
 * @param void
 * @return void
 */
void sortPokemon(void)
{
  int i = 0;
  while (i < size) {
    int j = i + 1;
    while (j < size) {
      if (comparePokemon(pokedex[i], pokedex[j]) > 0) {
        swapPokemon(i, j);
      }
      j++;
    }
    i++;
  }
}