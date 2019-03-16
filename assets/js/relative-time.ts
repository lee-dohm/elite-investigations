import {render} from 'timeago.js'

/**
 * Accepts a list of relative time elements and updates their `title` attribute to use the browser's
 * locale-specific date format.
 */
function timestampsToLocale(elements: NodeListOf<Element>): void {
  for (const element of elements as any as Element[]) {
    const datetime = element.getAttribute('datetime')
    if (datetime && datetime.length > 0) {
      const date = new Date(datetime)

      element.setAttribute('title', date.toLocaleString())
    }
  }
}

const nodes = document.querySelectorAll('relative-time')
render(nodes)
timestampsToLocale(nodes)
