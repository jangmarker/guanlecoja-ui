unless __karma__?
    window.describe = ->

# define sample application logic

m = angular.module("app", ["guanlecoja.ui"]);

m.config ($stateProvider, glMenuServiceProvider) ->

        groups = []
        for i in ["cab", "camera", "bug", "calendar", "ban", "archive", "edit"]
            group =
                name: i
                items: []
            for j in ["cab", "camera", "bug", "calendar", "ban", "archive", "edit"]
                group.items.push
                    name: i + j
                if i == "bug"
                    break
            groups.push group
            glMenuServiceProvider.addGroup
                name: group.name
                caption: _.string.humanize(group.name)
                icon: group.name
                order: group.name.length

        glMenuServiceProvider.setFooter [
            caption: "Github"
            href: "https://github.com/tardyp/guanlecoja-ui"
        ,
            caption: "Help"
            href: "https://github.com/tardyp/guanlecoja-ui/blob/master/Readme.md"
        ,
            caption: "About"
            href: "https://github.com/tardyp/guanlecoja-ui/blob/master/Readme.md"
        ]
        glMenuServiceProvider.setAppTitle("Guanlecoja-UI")
        for group in groups
            for item in group.items
                state =
                    controller: "dummyController"
                    template: "<div class='container'><div class='row'><h1>{{stateName}}</h1></div></div>"
                    name: item.name
                    url: '/' + item.name
                    data:
                        group: group.name
                        caption: _.string.humanize(item.name)
                $stateProvider.state(state)

m.controller "dummyController", ($scope, $state, glBreadcrumbService, glNotificationService) ->
    $scope.stateName = $state.current.name
    glNotificationService.notify(msg:"You just transitioned to #{$scope.stateName}!", title:"State transitions", group:"state")

    glBreadcrumbService.setBreadcrumb [
        caption: _.string.humanize($state.current.data.group)
    ,
        caption: _.string.humanize($state.current.name)
        sref: $state.current.name
    ]