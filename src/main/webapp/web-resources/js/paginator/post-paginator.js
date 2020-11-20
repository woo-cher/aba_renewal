/**
 * This class is used for paging `post` objects
 *
 * Need a conditions below)
 *
 * @see PageHelper
 */
class PostPaginator extends PageHelper {
    constructor(pageLength, bindingArea) {
        super(pageLength);
        this.bindingArea = bindingArea;
    }

    bindPosts(page, pageInfo) {
        let posts = pageInfo['list'];
        let count = 0;

        this.bindingArea.empty();

        for(let i = 0; i < posts.length; i++) {
            let post = posts[i];
            let postId = post.id;

            this.bindingArea.append(`
                <tr class="c-pointer relative" id="post${postId}" onclick="location.href='/posts/${postId}'">
                    ${post.postType.code === 'NOTICE' ? '<td class="notice aba">[공지]</td>' : '<td>' + postId + '</td>'}
                    <td>
                        <p class="td02">${post.title}</p>
                    </td>
                    <td class="aba">${post.register.nickName}</td>
                    <td>${post.createdAt.slice(2, 10).replaceAll("-", ".")}</td>
                    <td>${post.hits}</td>
                    <td class="management" onclick="event.cancelBubble=true">
                        <i class="fas fa-pen" style="margin-right: 10px;" onclick="location.href='/posts/form?postId=${postId}'"></i>
                        <i class="fas fa-trash-alt" style="margin-right: 10px;" onclick="doDelete(${postId})"></i>
                    </td>
                </tr>
            `)
        }
    }
}
