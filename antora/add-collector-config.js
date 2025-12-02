const fs = require('fs')
const path = require('path')
const yaml = require('js-yaml')

function readLinkMLSchema () {
  const linkmlFilename = fs.readdirSync("./model").filter(f => f.endsWith('.linkml.yml'))[0]
  const linkmlPath = path.join("./model", linkmlFilename)

  let doc
  try {
    const fileContent = fs.readFileSync(linkmlPath, "utf8")
    doc = yaml.load(fileContent) || {}
  } catch (err) {
    console.error(`Failed to read or parse YAML file: ${linkmlPath}`)
    console.error(err)
    process.exit(1)
  }

  return doc
}

module.exports.register = function () {
  this.once('contentAggregated', ({ contentAggregate, playbook }) => {
    const outDir = "./output/adoc"

    for (const { origins } of contentAggregate) {
      for (const origin of origins) {
        let linkmlSchema = readLinkMLSchema()

        let collector = {
          run: {
            command: `/antora/generate-documentation.sh`,
            env: [
              {
                'name': 'NAME',
                'value': linkmlSchema.name
              },
              {
                'name': 'TITLE',
                'value': linkmlSchema.title
              },
              {
                'name': 'VERSION',
                'value': linkmlSchema.version
              }
            ]
          },
          scan: {
            clean: true,
            dir: outDir
          }
        }

        Object.assign((origin.descriptor.ext ??= {}), { collector })
      }
    }
  })
}
