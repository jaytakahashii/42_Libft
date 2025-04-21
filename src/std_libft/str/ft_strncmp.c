/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strncmp.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jay <jay@student.42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/08/22 17:27:24 by jtakahas          #+#    #+#             */
/*   Updated: 2025/04/21 13:41:20 by jay              ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

int	ft_strncmp(const char *s1, const char *s2, size_t n)
{
	size_t			index;
	unsigned char	c1;
	unsigned char	c2;

	index = 0;
	while ((index < n) && (s1[index] || s2[index]))
	{
		c1 = (unsigned char)s1[index];
		c2 = (unsigned char)s2[index];
		if (c1 != c2)
			return (c1 - c2);
		index++;
	}
	return (0);
}
