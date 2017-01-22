export default function($scope) {
  videojs('archive');
  $scope.on('page:before-unload', () => videojs('archive').dispose());
}
