module.exports.register = function () {
  this.once('contentClassified', ({ contentCatalog, playbook }) => {
    const comp = contentCatalog.getComponents().find(c => c.name === 'ROOT')
    if (!comp || !comp.latest) return

    // resource id format: component::module:relative
    // include version if you want to pin a specific version:
    // `${comp.name}@${comp.latest.version}::ROOT:index.adoc`
    const startPageId = `${comp.name}@${comp.latest.version}::ROOT:index.adoc`

    // Set the site start page to the latest version's index page
    playbook.site = playbook.site || {}
    playbook.site.start_page = startPageId

    console.log('Set site.start_page ->', startPageId)
  })
}

