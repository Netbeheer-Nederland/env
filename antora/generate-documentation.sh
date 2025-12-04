#!/bin/env bash


function generate_documentation() {
    echo "Generating documentation…"
    echo
    mkdir -p $OUTDIR
    cp -r documentation/* $OUTDIR
    yq -i '.version = strenv(VERSION)' $OUTDIR/antora.yml
    yq -i '.title = strenv(TITLE)' $OUTDIR/antora.yml
    echo
    echo "Generating schema documentation…"
    echo
    mkdir -p "$OUTDIR/modules/schema"
    python -m linkml_asciidoc_generator.main \
        "model/$NAME.linkml.yml" \
        "$OUTDIR/modules/schema" \
        "--relations-diagrams"
    echo "Adding schema documentation to nav…"
    yq -i '.nav += ["modules/schema/nav.adoc"]' $OUTDIR/antora.yml
    echo
    echo -e "Copying generated artifacts to schema documentation…"
    for model in model/*; do \
        cp -r $model $OUTDIR/modules/schema/attachments/; \
        echo -e "To reference use:\n\txref:schema:attachment$"${model#model/}"[]"; \
    done
    echo -e "Copy examples (JSON) to schema documentation…"
    for example in examples/*.yml; do \
        example_name=$(basename $example); \
        gen-linkml-profile  \
            convert \
            "$example" \
            --out "$OUTDIR/modules/schema/attachments/${example_name%.*}.json"; \
        echo -e "To reference use:\n\txref:schema:attachment\$${example_name%.*}.json[]"; \
    done
    echo
}

generate_documentation
