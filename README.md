# Searh in list

The purpose of this flutter project is to search and filter within the list.
[User](https://jsonplaceholder.typicode.com/users) data on the [JsonPlaceHolder](https://jsonplaceholder.typicode.com) site is used.
Technique:

1. The data from Apid has been put into a list named allUser.
2. We create a list again for filtering (filterUser in this project)
3. A method named doSearch was created. A string was requested as a parameter.
Filtering is done in setState.
a. Filtering was done with the filterUser = allUser.where command.
4. This method was given to onChanced in textfield.

---