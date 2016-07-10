export function dispose() {
  $('.video-js').each((i, player) -> videojs(player.attr('id')).dispose());
}

export function refresh() {
  $('.video-js').each((i, player) -> videojs(player.attr('id')));
}

export default function(page, player) {
  page
    .on('turbolinks:unload', player.dispose)
    .on('turbolinks:change', player.refresh);
}
