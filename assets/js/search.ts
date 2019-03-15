function executeSearch(event: Event): void {
  if (searchTextElement && searchTypeElement) {
    if (searchTextElement.value !== '') {
      document.location.href = `/${searchTypeElement.value}/search?q=${searchTextElement.value}`
    } else {
      document.location.href = `/${searchTypeElement.value}`
    }
  }
}

const searchTextElement = document.querySelector('#search-text') as HTMLInputElement
const searchTypeElement = document.querySelector('#search-type') as HTMLInputElement
const searchButton = document.querySelector('#search-button') as HTMLButtonElement

if (searchButton) {
  searchButton.addEventListener('click', executeSearch)
}
