import ProjectDescription

let nameAttribute: Template.Attribute = .required("name")

let template = Template(
    description: "New module template",
    attributes: [
        nameAttribute,
        .optional("platform", default: "iOS")
    ],
    items: [
        .file(path: "\(nameAttribute)/Sources/\(nameAttribute).swift", templatePath: "OutputServices.stencil"),
        .file(path: "\(nameAttribute)/Tests/\(nameAttribute)Tests.swift", templatePath: "UnitTests.stencil"),
        .file(path: "\(nameAttribute)/Project.swift", templatePath: "StaticFrameworkModule.stencil")
    ]
)
